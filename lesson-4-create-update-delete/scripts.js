// const station = {
//     // coords: "31.34 23.11"
// };

// const {coords} = station;
// const [lat, lng] = coords.split(" ");

// const List = ({items = []})=> {
//     const elements = items.map(({id, name})=> <li key={id}>{name}</li>);

//     return <ul>{elements}</ul>
// }

// const users = [
//     {
//         id: 1,
//         name: "Bohdan"
//     }
// ];

// <List />
// manager, admin, superadmin
const createUser = ({role = "manager", first_name, last_name, hire_date = new Date()}) => {
    return {
        role,
        first_name,
        last_name,
        hire_date,
        get full_name(){
            return `${this.first_name} ${this.last_name}`
        }
    }
};

const newUser = createUser({first_name: "Bohdan", last_name: "Liamzin"});
console.log(newUser);
newUser.first_name = "Bogdan";
console.log(newUser.full_name); // console.log(newUser.full_name())