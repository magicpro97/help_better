import * as admin from "firebase-admin";
import messages from "./messages";
import users from "./users";
import messageGroups from "./message_groups"
admin.initializeApp();

/*const db = admin.firestore();*/
const cMessaging = admin.messaging();
export const onCreateMessage = messages.triggers.onCreateMessage(cMessaging);
export const onUserStateChange = users.triggers.onUserStateChange();
export const onMemberStateChange = messageGroups.triggers.onMemberStateChange();