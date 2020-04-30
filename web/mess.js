//<script src="https://www.gstatic.com/firebasejs/7.14.2/firebase-messaging.js"></script>


async function message() {

    console.log("heyyyy");

    const messaging = firebase.messaging();
    //messaging.usePublicVapidKey("BA2k5_y7dIKDCHF0Ch3VHZpz4oOyB5xtQKzJIUH7vz8XUR3ChQ8NEXl3jh0f1UchpCGOAsNsdvMuwHCVIkZ7SJg");
    console.log('have per head');
    var txt = await messaging.getToken();
    console.log(txt);
    return txt;
    
}