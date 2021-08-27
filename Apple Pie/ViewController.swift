//
//  ViewController.swift
//  Apple Pie
//
//  Created by Николай Никитин on 19.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var someImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowerd = 7
    var listOfWords = ["Абрикос" , "Авокадо" , "Айва" , "Алыча" , "Аннона" , "Апельсин" , "Баккорея" , "Бергамот" ,"Боярышник" ,"Вампи" ,"Восковница" ,"Гранат" , "Гревия" , "Грейпфрут" , "Грумичама" , "Груша" , "Джамбоза" , "Джамболан" , "Джамбу" , "Джекфрут" , "Инга" , "Инжир" , "Инокарпус" , "Какао" , "Каламондин" , "Канариум" , "Канистель" , "Капулин" , "Карамбола" , "Кариокар" , "Каштан" , "Кепель" , "Кешью" , "Клубничное дерево" , "Кокколоба" , "Кокосовая пальма" , "Кола" , "Конфетное дерево" ,"Кордия" , "Кофе" ,"Лайм" , "Лимон" , "Личи" ,"Макадамия" ,"Манго" , "Мандарин" , "Миндаль" , "Мирабель" , "Мирциария" , "Монгонго" , "Олива" , "Оранжекват" , "Орех" , "Папайя" , "Пекан" , "Персик" , "Питецеллобиум" , "Питомба" , "Рябина" , "Сизигиум" , "Сикомор" , "Склерокария" , "Слива" , "Тамарилло" , "Фисташка" , "Флакуртия" , "Хероспондиас" , "Хлебное дерево" , "Хурма" , "Цитрон" , "Чемпедак" , "Черёмуха" , "Черешня" , "Черимойя" , "Чупа-чупа" , "Шелковица" , "Ши" , "Эмблика" , "Юдзу" , "Яблоня" , "Ятоба"].shuffled()
    var totalWins = 0{
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    //MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        guard !listOfWords.isEmpty else{
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game (word: newWord, incorrectMovesRemaining: incorrectMovesAllowerd)
        updateUI()
        enableButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    guard segue.identifier == "showSecond" else { return }
                    guard let destination = segue.destination as? SecondViewController else { return }
                destination.listOfWords = ["Adventure", "Angry Birds", "Animal Crossing", "Another World", "Asteroids", "BioShock", "Bloodborne", "Braid", "Bubble Bobble", "Centipede", "Chrono Trigger", "Civilization", "Company of Heroes", "Contra", "Dance Dance Revolution", "Dark Souls", "Dead Space", "Destiny", "Diablo", "Dishonored", "Donkey Kong Country", "Doom", "Dota", "Duke Nukem", "Elder Scrolls", "Elite", "Fallout", "Final Fantasy", "Gauntlet", "Gears of War", "God of War", "Grand Theft Auto", "Guitar Hero", "Half-Life", "Halo", "Inside", "Joust", "Kart racing", "Life simulation", "Limbo", "Lode Runner", "Max Payne", "Maze", "Mega Man", "Minecraft", "Pong", "Portal", "Prince of Persia", "Quake", "The Legend of Zelda", "Warcraft", "Zork", ].shuffled()
                }
    
    func updateCorrectWordLabel(){
        var displayWord = [String]()
        for letter in currentGame.guessedWord{
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState() {
        if currentGame.incorrectMovesRemaining < 1 {
            totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func updateUI(){
        let movesRemainig = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemainig + 64) % 8
        let image = "Tree \(imageNumber)"
        someImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), Проигрыши: \(totalLosses)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    

// MARK: - IB Actions
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled  = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }

}

class SecondViewController: ViewController {
    
    
    // MARK: - IB Properties
    
    override func updateUI() {
        let movesRemainig = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemainig + 64) % 8
        let image = "Pacman\(imageNumber)"
        someImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), Проигрыши: \(totalLosses)"
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
}
