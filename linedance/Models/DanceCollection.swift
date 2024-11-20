import Foundation

struct DanceCollection {
    static let dances = [
        Dance(
            name: "Boot Scootin' Boogie",
            artist: "Brooks & Dunn",
            description: "A classic line dance perfect for beginners!",
            difficulty: .beginner,
            steps: [
                DanceStep(name: "Grapevine Right", 
                         description: "Step right with right foot, cross left foot behind, step right with right foot, touch left foot next to right",
                         stepNumber: 1,
                         imageSystemName: "arrow.right"),
                DanceStep(name: "Grapevine Left", 
                         description: "Step left with left foot, cross right foot behind, step left with left foot, touch right foot next to left",
                         stepNumber: 2,
                         imageSystemName: "arrow.left"),
                DanceStep(name: "Heel Splits",
                         description: "Split both heels out, bring them back together",
                         stepNumber: 3,
                         imageSystemName: "arrow.up.and.down")
            ]
        ),
        Dance(
            name: "Achy Breaky Heart",
            artist: "Billy Ray Cyrus",
            description: "An energetic line dance that swept the nation!",
            difficulty: .beginner,
            steps: [
                DanceStep(name: "Vine Right", 
                         description: "Step right, cross behind, step right, touch left",
                         stepNumber: 1,
                         imageSystemName: "arrow.right"),
                DanceStep(name: "Vine Left", 
                         description: "Step left, cross behind, step left, touch right",
                         stepNumber: 2,
                         imageSystemName: "arrow.left")
                // Add more steps
            ]
        ),
        Dance(
            name: "American Kids",
            artist: "Kenny Chesney",
            description: "A high beginner 32-count, 4-wall line dance choreographed by Randy Pelletier (June 2014)",
            difficulty: .highBeginner,
            steps: [
                // Section 1: Heels and Walks (Counts 1-8)
                DanceStep(
                    name: "Heel Touches and Walks",
                    description: "1-2: Touch right heel forward, step right next to left\n3-4: Touch left heel forward, step left next to right\n5-6: Step right forward, step left forward\n7-8: Tap right foot next to left twice",
                    stepNumber: 1,
                    imageSystemName: "arrow.up.and.down"
                ),
                
                // Section 2: Monterey Turn and Jazz Box (Counts 9-16)
                DanceStep(
                    name: "¼ Right Monterey Turn & Jazz Box",
                    description: "1-2: Point right to side, turn ¼ right stepping right beside left\n3-4: Point left to side, step left beside right\n5-6: Cross right over left, step back on left\n7-8: Step right to right side, step left slightly forward",
                    stepNumber: 2,
                    imageSystemName: "arrow.clockwise"
                ),
                
                // Section 3: Slides and Vine Turn (Counts 17-24)
                DanceStep(
                    name: "Slides and Vine Turn",
                    description: "1-2: Slide right to right side, touch left beside right\n3-4: Point left to left side, touch left beside right\n5-6: Step left foot to left side, cross right behind left\n7-8: Turn ¼ left step left foot to left side, brush right next to left",
                    stepNumber: 3,
                    imageSystemName: "arrow.left.and.right"
                ),
                
                // Section 4: Step and Turn Sequence (Counts 25-32)
                DanceStep(
                    name: "Steps and Turns with Claps",
                    description: "1-2: Step right forward, hold and clap\n3-4: Pivot ½ left (weight to left), hold and clap\n5-6: Step right forward, hold and clap\n7-8: Pivot ¼ left (weight to left), hold and clap",
                    stepNumber: 4,
                    imageSystemName: "arrow.triangle.turn.up.right.diamond"
                ),
                
                // Special Note
                DanceStep(
                    name: "Dance Note",
                    description: "RESTART: On 6th wall (2nd time facing 3 O'clock), dance through count 16 and restart. You'll be facing back wall when the restart occurs.",
                    stepNumber: 5,
                    imageSystemName: "info.circle"
                )
            ]
        ),
        Dance(
            name: "Party In The Hills",
            artist: "Why Don't We",
            description: "A high-energy 32-count, 2-wall advanced line dance choreographed by Fred Whitehouse, Shane McKeever & Joey Warren (September 2019)",
            difficulty: .advanced,
            steps: [
                DanceStep(
                    name: "Body Roll & Coaster Sequence",
                    description: "1-2: Body roll with L step forward\n2&3: Step back R, L next to R, step R forward\n4&5: Kick L forward, step L down, step R to right\n6&7&: Step L behind R, R to right, cross rock L over R, recover R\n8&1: Step L to left, touch R next to L, heavy step R to right",
                    stepNumber: 1,
                    imageSystemName: "figure.walk"
                ),
                DanceStep(
                    name: "Turn Combination",
                    description: "2&3: L behind R, ¼ turn R stepping R forward, step L forward\n4&5: Full turn R (½ turn R to R, ½ turn R to L), step back R\n6&7&: Step L back/out, R back, cross L over R, R back slightly\n8&1: ½ turn L stepping L forward, ¼ turn L touch R beside L, lean/press R to right",
                    stepNumber: 2,
                    imageSystemName: "arrow.clockwise.circle"
                ),
                DanceStep(
                    name: "Cross & Turn Pattern",
                    description: "2-3&4: Recover to L with R flick, cross shuffle R,L,R\n5-6: Slide L to left, ¼ turn L stepping R to right\n7&8: ¾ turn L stepping L behind R, step R in place, step L forward",
                    stepNumber: 3,
                    imageSystemName: "arrow.triangle.turn.up.right.circle"
                ),
                DanceStep(
                    name: "Grind & Rock Sequence",
                    description: "&12&: Ball step R next to L, grind L heel forward, recover R\n3&4&: Rock R forward, recover L, rock R side, recover L\n5-6-7: Back R sweep L, back L sweep R, back R pop L knee forward (prep for turn)\n8&1: Step L forward, ½ turn L stepping R back, ½ turn L stepping L forward",
                    stepNumber: 4,
                    imageSystemName: "arrow.left.and.right.circle"
                )
            ]
        )
    ]
} 