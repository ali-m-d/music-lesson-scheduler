# README

This README would normally document whatever steps are necessary to get the
application up and running.

Built using Rails 6, JavaScript and PostgresQL, for inclusion into a website owned by a music teacher, this application allows an authenticated user to schedule a lesson by picking a date and selecting a duration.

This application utilizes the Stripe API to provide the user with the ability to pay for their lesson in advance using a credit or debit card. Once a lesson has been scheduled, an email confirming the lesson time and amount paid is dispatched to the user, and the user is presented with a summary of their booking and a form for leaving the teacher a message. The lesson summary view utilizes Ajax to dynamically render newly created messages without needing to fetch the full page data from the server.

A user wishing to view a summary of their upcoming lessons can visit the Dashboard and use tabbed navigation to toggle between a calendar view and a list view.

Administrator permissions allow the site owner to view lessons scheduled by all users.
