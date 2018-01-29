import Expo from 'expo-server-sdk';

// Create a new Expo SDK client
const expo = new Expo();

const somePushTokens = [];
// Create the messages that you want to send to clents
const messages = [];
for (const pushToken of somePushTokens) {
  // Each push token looks like ExponentPushToken[xxxxxxxxxxxxxxxxxxxxxx]

  // Check that all your push tokens appear to be valid Expo push tokens
  if (Expo.isExpoPushToken(pushToken) === false) {
    console.error(`Push token ${pushToken} is not a valid Expo push token`);
  } else {

    /*
     * Construct a message
     * (see https://docs.expo.io/versions/latest/guides/push-notifications.html)
     */
    messages.push({
      body: 'This is a test notification',
      data: { withSome: 'data' },
      sound: 'default',
      to: pushToken
    });
  }
}

/*
 * The Expo push notification service accepts batches of notifications so
 * that you don't need to send 1000 requests to send 1000 notifications. We
 * recommend you batch your notifications to reduce the number of requests
 * and to compress them (notifications with similar content will get
 * compressed).
 */
const chunks = expo.chunkPushNotifications(messages);

async function sendNotifications() {

  /*
   * Send the chunks to the Expo push notification service. There are
   * different strategies you could use. A simple one is to send one chunk at a
   * time, which nicely spreads the load out over time:
   */
  for (const chunk of chunks) {
    try {
      const receipts = await expo.sendPushNotificationsAsync(chunk);
      console.log(receipts);
    } catch (error) {
      console.error(error);
    }
  }
}
sendNotifications();