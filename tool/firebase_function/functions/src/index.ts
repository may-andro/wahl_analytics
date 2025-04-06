import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import * as nodemailer from "nodemailer";

admin.initializeApp();

// Set up the Nodemailer transporter using Gmail
const nodemailerTransporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true,
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

export const sendContactUsEmail = functions
    .region("europe-west3")
    .firestore
    .document("contact_us/{documentId}")
    .onCreate(async (snap) => {
      try {
        const data = snap.data();

        /* eslint-disable max-len */
        const emailBody = `
          <p>Hello Pitter!</p>

          <p>We have received a new message:</p>
          <table style="border-collapse: collapse; width: 100%;">
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd;"><strong>Name:</strong></td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.name}</td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd;"><strong>Email:</strong></td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.email}</td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd;"><strong>Message:</strong></td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.message}</td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd;"><strong>Uploaded At:</strong></td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.uploadedAt}</td>
            </tr>
          </table>

          <p>Regards,</p>
          <p>Your Team</p>
        `;
        /* eslint-enable max-len */

        const mailOptions = {
          from: process.env.EMAIL_USER,
          to: process.env.EMAIL_TO,
          subject: "Contact Us [Wahl Analytics]",
          html: emailBody,
        };

        await nodemailerTransporter.sendMail(mailOptions);
      } catch (error) {
        console.error("Error sending email:", error);
        throw new functions.https.HttpsError(
            "internal",
            "Failed to send email."
        );
      }
    });

export const sendCareerEmail = functions
    .region("europe-west3")
    .firestore
    .document("career/{documentId}")
    .onCreate(async (snap) => {
      try {
        const data = snap.data();

        // Check if the environment is 'prod'
        const env = data.env;
        if (env !== "prod") {
          console.log("Skipping email send as ENV: ${env} is not 'prod'");
          return;
        }

        /* eslint-disable max-len */
        const emailBody = `
          <p>Hello Pitter!</p>

          <p>We have received a career/job request from <strong>${data.email}</strong>.</p>

          <p><strong>Candidate Details:</strong></p>
          <table style="border-collapse: collapse; width: 100%; font-family: Arial, sans-serif; font-size: 14px;">
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd; font-weight: bold;">Name</td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.name}</td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd; font-weight: bold;">Country</td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.country}</td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd; font-weight: bold;">Applying For</td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.role}</td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd; font-weight: bold;">Message</td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.message}</td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd; font-weight: bold;">Resume</td>
              <td style="padding: 8px; border: 1px solid #ddd;"><a href="${data.resumeUrl}" target="_blank">View Resume</a></td>
            </tr>
            <tr>
              <td style="padding: 8px; border: 1px solid #ddd; font-weight: bold;">Request Made On</td>
              <td style="padding: 8px; border: 1px solid #ddd;">${data.uploadedAt}</td>
            </tr>
          </table>

          <p>Please contact the candidate if the profile seems interesting.</p>

          <p>Regards,<br/>Your Team</p>
        `;
        /* eslint-enable max-len */

        const mailOptions = {
          from: process.env.EMAIL_USER,
          to: process.env.EMAIL_TO,
          subject: "Career @ [Wahl Analytics]",
          html: emailBody,
        };

        await nodemailerTransporter.sendMail(mailOptions);
      } catch (error) {
        console.error("Error sending email:", error);
        throw new functions.https.HttpsError(
            "internal",
            "Failed to send email."
        );
      }
    });


export const sendDevMenuAuthEmail = functions
    .region("europe-west3")
    .runWith({
      enforceAppCheck: true,
    })
    .https.onCall(async () => {
      try {
        const code = generateCode();

        // Prepare email content
        const emailText = `Your verification code is: ${code}`;
        const emailHtml = `<p>Your verification code is: <b>${code}</b></p>`;

        const mailOptions = {
          from: process.env.EMAIL_USER,
          to: process.env.EMAIL_TO,
          subject: "Developer Menu Access",
          text: emailText,
          html: emailHtml,
        };

        await nodemailerTransporter.sendMail(mailOptions);

        const docRef = await admin.firestore()
            .collection("verification_codes")
            .add({
              code: code,
              createdAt: admin.firestore.FieldValue.serverTimestamp(),
            });

        return {message: "Email sent successfully!", docId: docRef.id};
      } catch (error) {
        console.error("Error sending email:", error);
        throw new functions.https.HttpsError(
            "internal",
            "Failed to send email."
        );
      }
    });

// Function to generate a 6-digit random code
const generateCode = (): string => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};
