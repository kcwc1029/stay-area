// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { collection, getDocs, getFirestore } from "firebase/firestore";// 自己加的部分

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyAdBEuDofYesQqhCszdnyMYmbHkfkekWgw",
    authDomain: "my-project-firebase-test-001.firebaseapp.com",
    projectId: "my-project-firebase-test-001",
    storageBucket: "my-project-firebase-test-001.appspot.com",
    messagingSenderId: "1068303770904",
    appId: "1:1068303770904:web:2758f78c9dfb1a3e9d2a6d",
    measurementId: "G-NJYVWPLQ2H",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

// 自己加的部分
const db = getFirestore();
const collect = collection(db, "movie"); //指定collection "movie"

getDocs(collect)
    .then((data) => {
        data.docs.forEach((i) => {
            console.log(i.id);
            console.log(i.data());
        });
    })
    .catch(console.log("error"));
