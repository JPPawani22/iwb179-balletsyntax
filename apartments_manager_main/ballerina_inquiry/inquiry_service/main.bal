import ballerina/http;
import ballerina/mail;
import ballerina/firebase;

// Define the mail configuration
mail:Sender mailSender = checkpanic mail:Sender {
    host: "smtp.gmail.com",
    port: 465,
    user: "example@gmail.com", //user email
    password: "apppasssword", //app password
    secureSocket: mail:SSL
};

// Firestore client
firebase:Client firestoreClient = checkpanic firebase:createClient("hostel-management-app-4ae0f");

// Service to handle announcements, change the IP address according to the emulator using or for the web use localhost
service /announcement on new http:Listener(8080) {
    
     // CORS configuration
    http:CorsConfig corsConfig = {
        allowOrigins: ["*"]   // Allow all origins (for development)
        allowMethods: ["GET", "POST"], // Allowed HTTP methods
        allowHeaders: ["Content-Type", "Authorization"], // Allowed headers
        allowCredentials: false // Allow credentials (if needed)
    };

    // Resource function to send announcements
    resource function post sendAnnouncement(http:Caller caller, json payload) returns error? {
        string title = check payload.title.toString();
        string message = check payload.message.toString();
        string[] emails = check payload.emails.toStringArray();

        // Send emails
        foreach string email in emails {
            mail:Email emailMessage = {
                from: "pawani02jp@gmail.com",
                to: email,
                subject: title,
                body: message
            };
            // Handle potential errors while sending email
            error? sendError = mailSender->send(emailMessage);
            if (sendError is error) {
                log:printError("Error sending email to " + email, sendError);
            }
        }

        // Save announcement to Firestore
        json announcementData = {
            "title": title,
            "message": message,
            "emails": emails
        };

        // Insert the announcement into the Firestore
        error? firestoreError = firestoreClient->insert("announcements", announcementData);
        if (firestoreError is error) {
            log:printError("Error inserting announcement into Firestore", firestoreError);
            return firestoreError; // Return the error to the caller
        }

        // Return success response
        check caller->respond("Announcements sent successfully");
    }

    // Test endpoint
    resource function get hello() returns string {
        return "Hello, World!";
    }
}
