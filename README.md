# CustomContactBook

# About the Task ;-

Create an Application that manages contacts. All the data will be saved locally

on the device.

We need to create 2 views (ListView &amp; DetailsView). Also we need to create a

model class (DataManager) that can do all operations (Add, Edit, Delete) and

notify the view using handlers.

1- ListView:

- It has a ListView to show the list of my contacts. It will show the Name,

Mobile Number, Email address, Photo for each contact. When I tap on one

item, you show an action sheet with the following options:

1- Show Details: push the second view (DetailsView) that has form to

show all the details of the contact.

2- Call: show standard call popview.

3- Send an Email: show standard mail composer controller.

- Show ActivityIndicator View during loading the list.

- Initiate data loading using the DataManger and provide the handler for it to

be got invoked once data finished load.

- Dismiss ActivityIndicator View.

- Bind the data to ListView cells.

- It has “Add” button on the right top corner of the view. Click on Add button

will push to second view (DetailsView) to add new contact.

- It has “Delete” button when the user swipe any item as standard behavior

to allow the user to delete the selected contact in case and show proper

message to the user in both cases (successful or failure).

- DetailsView

- It has a form that shows all the information of the contact. The form of

contact details will include the following fields:

1- First Name: Alphabetical field and it is mandatory.

2- Last Name: Alphabetical field and it is mandatory.

3- Mobile Number: Numeric field and it is mandatory.

4- Email Address: it is mandatory.

5- Birth Date: Date field and it is not mandatory.

6- Address: text field and it is not mandatory.

7- Photo: it is not mandatory.

You have to consider standard validation for each field.

- It has Edit button on the right top corner of the view in case the user needs

to edit the details of the contact. When the user click on this button will show

“Cancel” &amp; “Save” buttons on the top left and right corners either to cancel the

operation or to save the changes.

*********************************
