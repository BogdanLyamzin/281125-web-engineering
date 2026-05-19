import connectDatabase from "./connectDatabase.js";
import Contact from "../models/Contact.js";
import User from "../models/User.js";

await connectDatabase();
// await Contact.create({ phone: "1234567890" });
// const contacts = await Contact.findAll({
//     where: {
//         phone: "1234567890"
//     }
// });
console.log(await User.findAll())
// console.log(JSON.stringify(contacts));