#import "@local/rusterd:0.1.0": erd

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
`, detail: "pk_fk", notation: "text", width: 100%)
