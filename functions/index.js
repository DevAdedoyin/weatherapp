import { onSchedule } from "firebase-functions/v2/scheduler";
import admin from "firebase-admin";

admin.initializeApp();

export const sendDailyNotification = onSchedule(
  {
    schedule: "0 5 * * *",
    timeZone: "London/United Kingdom",
  },
  async (event) => {
    const message = {
      notification: {
        title: "Daily Weather Alert",
        body: "Your personalized weather update is ready. Tap to see today’s forecast.",
      },
      topic: "weather",
      data: { screen: "notifications" },
    };

    await admin.messaging().send(message);
    console.log("Daily notification sent!");
  }
);
