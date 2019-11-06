import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();

const db = admin.firestore();

export const createMessageTrigger = functions.firestore
  .document("message_groups/{messageGroupId}/{messages}/{messageId}")
  .onWrite((change, context) => {
    if (context.params.messages === "messages") {
      const createTime = change.after.createTime;
      if (change.after.ref.parent.parent !== null) {
        const doc = change.after.ref.parent.parent;
        return db
          .collection("message_groups")
          .doc(doc.id)
          .update({
            updated: createTime
          })
          .catch(err => console.log(err));
      }
    }
    return null;
  });
