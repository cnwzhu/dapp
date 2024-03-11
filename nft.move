module nft::m_nft {
    use sui::tx_context::{sender, TxContext};
    use std::string::{utf8, String};
    use sui::transfer::{Self, public_transfer};
    use sui::object::{Self, UID};
    use sui::package;
    use sui::display;

    struct MNFT has key, store {
        id: UID,
        name: String,
        image_url: String
    }

    struct M_NFT has drop {}

    fun init(otw: M_NFT, ctx: &mut TxContext) {
        let keys = vector[
            utf8(b"name"),
            utf8(b"image_url"),
        ];

        let values = vector[
            utf8(b"{name}"),
            utf8(b"{image_url}"),
        ];

        let publisher = package::claim(otw, ctx);

        let display = display::new_with_fields<MNFT>(
            &publisher, keys, values, ctx
        );

        display::update_version(&mut display);

        transfer::public_transfer(publisher, sender(ctx));
        transfer::public_transfer(display, sender(ctx));
    }

    public entry fun mint(ctx: &mut TxContext) {
        let name = utf8(b"github:cnwzhu");
        let image_url = utf8(b"https://avatars.githubusercontent.com/u/16802025?v=4");
        let nft = MNFT {
            id: object::new(ctx),
            name,
            image_url
        };
        public_transfer(nft, sender(ctx));
    }
}