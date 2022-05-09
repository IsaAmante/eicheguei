import 'dart:async';
import 'package:common/common.dart';

class UserService {
  static UserService? _instance;
  late FirebaseFirestore _firestore;

  AppUser? _user;
  AppUser? get user => _user;

  Stream<QuerySnapshot<Map<String, dynamic>>>? orderStream;

  factory UserService() {
    _instance ??= UserService._internalConstructor();
    return _instance!;
  }

  UserService._internalConstructor() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<AppUser?> getUserInfoByEmail(
    String? email,
    String? name,
  ) async {
    _user = null;
    if (email != null) {
      var snapshot = await _firestore.collection('users').doc(email).get();
      if (snapshot.exists) {
        String name = snapshot.data()!['name'] ?? '';
        DocumentReference<Map<String, dynamic>> condominiumReference =
            snapshot.data()!['condominium'];
        Condominium? condominium;
        if ((await condominiumReference.get()).exists) {
          condominium =
              Condominium.fromMap((await condominiumReference.get()).data()!);
          condominium.condRef = condominiumReference.path;
        }

        _user = AppUser(
          uid: email,
          name: name,
          access: parseToAccessType(snapshot.data()!['access']),
          condominium: condominium,
        );
      } else {
        Invitation? invitation = await getInvitation(email);
        if (invitation != null) {
          await createUser(
            AppUser(
              uid: email,
              name: name ?? '',
              condominium: invitation.condominium,
              access: invitation.access,
              isComplete: false,
            ),
            invitation.condRef!,
          );
        }
      }
    }

    return _user;
  }

  Future<void> createUser(
    AppUser user,
    String condominiumRef,
  ) async {
    _user = user;
    await _firestore.collection('users').doc(user.uid).set(
      {
        'name': user.name,
        'uid': user.uid,
        'access': user.access.toString(),
        'birthday': user.birthday,
        'condominium': _firestore.doc(condominiumRef),
      },
    );
  }

  Future<Invitation?> getInvitation(String? email) async {
    Invitation? invitation;
    if (email != null) {
      var snapshot =
          await _firestore.collection('invitations').doc(email).get();
      if (snapshot.exists) {
        DocumentReference<Map<String, dynamic>> condominiumRef =
            snapshot.data()!['condominium'];
        var condDoc = await condominiumRef.get();
        if (condDoc.exists) {
          var condominium = Condominium.fromMap(condDoc.data()!);
          condominium.condRef = condominiumRef.path;

          invitation = Invitation(
            condominium: condominium,
            condRef: condominiumRef.path,
            access: parseToAccessType(condDoc.data()!['permission']),
            accepted: false,
          );
        }
      }
    }
    return invitation;
  }

  Future<String> createCondominium(Condominium condominium) async {
    var reference =
        await _firestore.collection('condominiums').add(condominium.toMap());
    return reference.path;
  }
}
