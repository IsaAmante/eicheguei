import 'package:common/common.dart';

class InvitationsService {
  static InvitationsService? _instance;
  late FirebaseFirestore _firestore;

  factory InvitationsService() {
    _instance ??= InvitationsService._internalConstructor();
    return _instance!;
  }

  InvitationsService._internalConstructor() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> sendInvitation(Invitation invitation, String email) async {
    await _firestore.collection('invitations').doc(email).set({
      'access': invitation.access.toString(),
      'accepted': invitation.accepted,
      'condominium': _firestore.doc(invitation.condominium.condRef ?? ''),
    });
  }

  Future<List<Invitation>> getInvitations() async {
    return [];
  }
}
