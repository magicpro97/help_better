import * as admin from "firebase-admin";
import message from "./message";
admin.initializeApp();

export const onCreateMessage = message.triggers.onCreateMessage();