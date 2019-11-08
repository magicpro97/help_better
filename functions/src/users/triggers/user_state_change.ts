import * as functions from "firebase-functions";
import { Firestore } from "@google-cloud/firestore";
import { FCollection, User, Message } from "../../constants";

export default function onUserStateChange(db: Firestore) {
  const { USERS, MESSAGES, MESSAGE_GROUPS } = FCollection;
  return functions.firestore
    .document(`${USERS}/{userId}`)
    .onWrite((change, _) => {
      const user = change.after.data() as User;
      if (user !== undefined) {
        if (user.online) {
          return db
            .collection(`${MESSAGE_GROUPS}`)
            .where("memberIds", "array-contains", user.id)
            .get()
            .then(mGSnapshot => {
              for (const mGDoc of mGSnapshot.docs) {
                mGDoc.ref
                  .collection(`${MESSAGES}`)
                  .get()
                  .then(mSnapshot => {
                    for (const mDoc of mSnapshot.docs) {
                      const message = mDoc.data() as Message;
                      if (
                        message.status !== "RECEIVED" &&
                        message.userId !== user.id
                      ) {
                        mDoc.ref
                          .update({
                            status: "RECEIVED"
                          })
                          .catch(err => console.log(err));
                      }
                    }
                  })
                  .catch(err => console.log(err));
              }
            })
            .catch(err => console.log(err));
        }
        return null;
      }
      return null;
    });
}
