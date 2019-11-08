import * as admin from "firebase-admin";
import messages from "./messages";
import users from "./users";
admin.initializeApp();

const db = admin.firestore();
export const onCreateMessage = messages.triggers.onCreateMessage();
export const onUserStateChange = users.triggers.onUserStateChange(db);