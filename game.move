module game::demo_game{
    use std::string;
    use sui::event;
    use std::debug;
    use sui::clock::{Self, Clock};

    const EInvalidNumber: u64 = 0;
    struct GameResult has drop,copy{
        number: u64,
        computer_number: u64,
        result: string::String
    }

    public fun play(number: u64, clock: &Clock){
        assert!(number <= 9,EInvalidNumber);
        assert!(number >= 0,EInvalidNumber);
        let computer_number = ((clock::timestamp_ms(clock) % 9) as u64);
        let resultstr = if (number == computer_number) {
            string::utf8(b"tie")
        } else if (number > computer_number) {
            string::utf8(b"win")
        } else {
            string::utf8(b"lose")
        };
        let result = GameResult {
            number: number,
            computer_number: computer_number,
            result: resultstr
        };
        event::emit(result);
    }
 
}