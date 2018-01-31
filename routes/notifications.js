const Expo = require('expo-server-sdk');
async function sendNotifications(body, data, receivers) {
  const expo = new Expo(),
      messages = [];
  for (const pushToken of receivers) {
    // Each push token looks like ExponentPushToken[xxxxxxxxxxxxxxxxxxxxxx]

    // Check that all your push tokens appear to be valid Expo push tokens
    if (Expo.isExpoPushToken(pushToken) === false) {
      console.error(`Push token ${pushToken} is not a valid Expo push token`);
    } else {
      messages.push({
        body,
        data,
        sound: 'default',
        to: pushToken
      });
    }
  }
  const chunks = expo.chunkPushNotifications(messages);
  for (const chunk of chunks) {
    try {
      await expo.sendPushNotificationsAsync(chunk);
    } catch (error) {
      console.error(error);
    }
  }
}

module.exports = { sendNotifications };