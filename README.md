# Ramen Ho!

Have you ever rolled up to your favorite ramen shop only to discover that there's a huge crowd already waiting to get seated? You don't have time to wait! Well, maybe there's a way to avoid those lines. Enter 'Ramen Ho'!

Ramen Ho! is two apps - a mobile app that informs the ramen-hungry customer which ramen shops have the shortest wait times, and a tablet app that allows ramen shop proprietors to make sure they're seating their customers efficiently. By broadcasting live waittimes to customers on the hunt, Ramen Ho! can help the ramen-eater spend less time driving around and more time eating those delicious noodles, and allow ramen shops to make sure they've always got customers on the hook!

Currently, the app is just a prototype! The next step would be to find some __partners__ - restaurants interesting in using the waitlist app with their customers. We don't currently have the bandwidth to pursue these ends, and the app is not in development. But if you're interested in the app, do get in touch!

This project was a ___team effort___. It was built with :heart_eyes:, :cry:, & :sweat: by [quyenttran](https://github.com/quyenttran), [lmdasaro](https://github.com/lmdasaro), [mdinh7](https://github.com/mdinh7) and yours truly.

## Project Details

* __It's Great for Ramen Shops__: Restauranteurs get a waitlist app to serve their customers more efficiently! And because their waittimes are broadcasted to mobile users, lesser-known shops will get more exposure, and shops that are already popular will never have lulls in business.
* __It's Convenient for Customers__: Customers looking for a ramen fix don't have to drive around to different shops to find the shortest line! And when they arrive, they can go grab a beer while they wait for their table! They'll get a text message when it's ready.
* __It's Smart__: Waittimes get smarter over time - expected waittimes for any given time and day are based on averages of prior waittimes.

___Ruby Version___: 2.4.0  
___Database___: PostgreSQL  
___Dependencies___: Devise, Twilio, Faker, Font-Awesome, Bourbon, Neat

## Functionality

### For Customers on the Move - Browsing
Hungry mobile users can browse the waittimes of local ramen restaurants. They can also see opening hours and find directions. (In the prototype, the waittimes are simulated.) | 
------------------------------ | 
![Browsing](https://github.com/pnewsam/ramen-ho/blob/master/readme_assets/browsing_desktop.gif "Browsing") |

### For Business Owners - Logging In
Business owners will be given accounts. Using tablets, they can log on to their accounts, where they'll find a waitlisting app for their use. |
------------------------------ | 
![Logging In](https://github.com/pnewsam/ramen-ho/blob/master/readme_assets/logging_in.gif "Logging In") |

### For Patrons - Signing up for the Waitlist
Patrons visiting the shop will be greeted by the waitlist app. They can sign up for the waitlist, providing their phone numbers. |
------------------------------ |
![Signing up for the Waitlist](https://github.com/pnewsam/ramen-ho/blob/master/readme_assets/adding_parties.gif "Signing up for the Waitlist") |

### For Waitstaff - Alerting and Seating Parties
As tables open up, waitstaff can seat patrons using the waitlist. Waitstaff are provided with a secret PIN number, which they can use to unlock the functions of seating and alerting patrons. Both actions - seating and alerting - are set up to send a text message. |
------------------------------ | 
![Seating Parties](https://github.com/pnewsam/ramen-ho/blob/master/readme_assets/seating_parties.gif "Seating Parties") |
