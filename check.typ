#import "lib.typ": erd

#erd(`
entity User {
    id int pk
    email string unique not null
}

entity Order {
    id int pk
    user_id int fk -> User.id
}

rel {
    User 1 -- * Order : "places"
}

focus checkout {
    include User, Order
}
`, focus: "checkout",detail: "all", notation: "text", legend: true, dense: false, aspect: "4:4", width: 100%)
