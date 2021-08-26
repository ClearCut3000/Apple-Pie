//
//  ViewController.swift
//  Apple Pie
//
//  Created by Николай Никитин on 19.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARK: - Properties
    var currentGame: Game!
    let incorrectMovesAllowerd = 7
    var listOfWords = [
        "Абрикос" ,
        "Авокадо" ,
        "Азимина" ,
        "Айва" ,
        "Алыча" ,
        "Аннона" ,
        "Апельсин" ,
        "Араза" ,
        "Баккорея" ,
        "Белая сапота" ,
        "Бергамот" ,
        "Билимби" ,
        "Боярышник" ,
        "Бразильский орех" ,
        "Вампи" ,
        "Восковница" ,
        "Гранат" ,
        "Гревия" ,
        "Грейпфрут" ,
        "Грумичама" ,
        "Груша" ,
        "Дакриодес" ,
        "Джамбоза" ,
        "Джамболан" ,
        "Джамбу" ,
        "Джекфрут" ,
        "Довиалис кафрский" ,
        "Дуриан цибетиновый" ,
        "Дынное дерево" ,
        "Дюки" ,
        "Жаботикаба (растение)" ,
        "Звёздчатое яблоко" ,
        "Земляничное дерево" ,
        "Инга" ,
        "Инжир" ,
        "Инокарпус" ,
        "Какао" ,
        "Каламондин" ,
        "Канариум" ,
        "Канистель" ,
        "Капулин" ,
        "Карамбола" ,
        "Кариокар" ,
        "Каштан" ,
        "Кепель" ,
        "Кешью" ,
        "Клубничное дерево" ,
        "Кокколоба" ,
        "Кокосовая пальма" ,
        "Кола" ,
        "Конфетное дерево" ,
        "Кордия" ,
        "Корейский кедр" ,
        "Корлан" ,
        "Кофе" ,
        "Кумкват" ,
        "Купуасу" ,
        "Лайм" ,
        "Лещина" ,
        "Лимон" ,
        "Личи" ,
        "Лукума" ,
        "Макадамия" ,
        "Манго" ,
        "Мандарин" ,
        "Миндаль" ,
        "Мирабель" ,
        "Мирциария" ,
        "Монгонго" ,
        "Мускатник" ,
        "Мушмула" ,
        "Олива" ,
        "Оранжекват" ,
        "Орех" ,
        "Папайя" ,
        "Пекан" ,
        "Персик" ,
        "Питецеллобиум" ,
        "Питомба" ,
        "Помело" ,
        "Померанец" ,
        "Пулазан" ,
        "Пурума" ,
        "Рамбутан" ,
        "Ренклод" ,
        "Роллиния" ,
        "Рябина" ,
        "Салак" ,
        "Сизигиум" ,
        "Сикомор" ,
        "Склерокария" ,
        "Слива" ,
        "Тамарилло" ,
        "Тамаринд" ,
        "Тернослива" ,
        "Фейхоа" ,
        "Филлантус" ,
        "Финик" ,
        "Фисташка" ,
        "Флакуртия" ,
        "Хероспондиас" ,
        "Хлебное дерево" ,
        "Хурма" ,
        "Цитрон" ,
        "Чемпедак" ,
        "Черёмуха" ,
        "Черешня" ,
        "Черимойя" ,
        "Чупа-чупа" ,
        "Шелковица" ,
        "Ши" ,
        "Эмблика" ,
        "Юдзу" ,
        "Яблоня" ,
        "Ятоба"].shuffled()
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
        treeImageView.image = UIImage(named: image)
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

