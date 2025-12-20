module meow_nft::meow_nft {
    use std::string::{Self, String};
    use sui::url::{Self, Url};
    use sui::event;
    use sui::package;
    use sui::display;

    /// An example NFT that can be minted by anybody
    public struct MeowNFT has key, store {
        id: UID,
        name: String,
        description: String,
        url: Url,
    }

    // OTW (One Time Witness)
    public struct MEOW_NFT has drop {}

    /// Event emitted when an NFT is minted
    public struct NFTMinted has copy, drop {
        object_id: ID,
        creator: address,
        name: String,
    }

    fun init(otw: MEOW_NFT, ctx: &mut TxContext) {
        let keys = vector[
            string::utf8(b"name"),
            string::utf8(b"description"),
            string::utf8(b"image_url"),
            string::utf8(b"img_url"),
            string::utf8(b"url"),
            string::utf8(b"project_url"),
            string::utf8(b"creator"),
        ];

        let values = vector[
            string::utf8(b"{name}"),
            string::utf8(b"{description}"),
            string::utf8(b"{url}"),
            string::utf8(b"{url}"),
            string::utf8(b"{url}"),
            string::utf8(b"https://sui.io"),
            string::utf8(b"Meow Creator")
        ];

        let publisher = package::claim(otw, ctx);

        let mut display = display::new_with_fields<MeowNFT>(
            &publisher, keys, values, ctx
        );

        display::update_version(&mut display);

        transfer::public_transfer(publisher, ctx.sender());
        transfer::public_transfer(display, ctx.sender());
    }

    /// Mint a new NFT
    public entry fun mint(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        recipient: address,
        ctx: &mut TxContext
    ) {
        let nft = MeowNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: url::new_unsafe_from_bytes(url)
        };

        event::emit(NFTMinted {
            object_id: object::id(&nft),
            creator: ctx.sender(),
            name: nft.name,
        });

        transfer::public_transfer(nft, recipient);
    }

    /// Burn (destroy) an NFT
    public entry fun burn(nft: MeowNFT) {
        let MeowNFT { id, name: _, description: _, url: _ } = nft;
        object::delete(id);
    }
}
