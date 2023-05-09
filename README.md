# 67272-cafe23
Website application that helps support the functionality of a cafe management system.

First `rails db:contexts` to fill your database with matching information. Then run `rails s` to open the server, and connect using the URL `localhost:3000/login`. This will bring you to the login page.

There are 3 different users you can browse through.

To view the **admin's** page, login with username `alex` and password `secret`.
To view the **manager's** page, login with username `kathryn` and password `secret`.
To view the **employee's** page, login with username `ralph` and password `secret`.

The website is not fully fleshed out, though key functionalities are tackled. See below for a more scenarios covered in the website:


For Administrators

The administrator logs in and chooses the payroll option for employees. The admin gets a form that allows him/her to choose the employee he/she wants to calculate payroll for, as well as a start and end date that the payroll report will cover. After entering this information, the admin gets a report on the employee's payroll, including the time period in question, the employee name, SSN, current pay grade, current rate, the number of hours worked in that period, and the money earned for that work.

The administrator logs in and chooses the payroll option for stores. The admin gets a form that allows him/her to choose the store he/she wants to calculate payroll for, as well as a start and end date that the payroll report will cover. After entering this information, the admin gets a report for the store and time period in question. This report provides in list form the payroll report for each employee who has a shift in the time period; the contents of the employee report match the requirements of the first scenario.

The administrator logs in and creates a new employee, Luke Skywalker. Once it is confirmed that Luke has been added to the system, the administrator assigns Luke to the CMU store. Upon submission, the administrator get appropriate feedback that the task has been correctly completed.

For Managers

The manager logs in and chooses the payroll option for stores. The manager gets a form that allows him/her to choose a start and end date that the payroll report will cover; unlike the admin, there is no option to select a store as the manager's current store is assumed. After entering this information, the manager gets a report for the store and time period in question. This report provides in list form the payroll report for each employee who has a shift in the time period; the contents of the employee report match the requirements of the comparable admin scenario.

The manager logs in to create a new shift for an employee. The manager gets a form that allows him/her to select the active employee for the shift, the date of the shift, and the start time of the shift. If the end time is felt blank, the system will make the end time 3 hours after start time; otherwise the end time will be whatever the manager sets it to. Upon submission, the manager get appropriate feedback that the task has been correctly completed.

The manager logs in to record a job to a completed shift. In this case, the manager clicks on the first completed shift for Ralph Wilson. Seeing that Ralph worked the cashier job, the manager also adds the job of barista to the jobs Ralph completed that shift. Upon submission, the manager get appropriate feedback that the task has been correctly completed.

For Employees

An employee logs in and is immediately taken to a list of upcoming shifts the employee is scheduled for. If one of the shifts on the list is schedule for today, then there will be an option on the page to start the shift. Choosing that option will start the time clock and begin the shift and the employee receives appropriate feedback that this is the case.

An employee logs in and is immediately taken to a list of upcoming shifts the employee is scheduled for. If one of the shifts on the list is schedule already under way, then there will be an option on the page to end the shift. Choosing that option will stop the time clock and end the shift and the employee receives appropriate feedback that this is the case.
