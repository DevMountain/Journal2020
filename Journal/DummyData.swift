//
//  DummyData.swift
//  Journal
//
//  Created by Andrew Madsen on 2/25/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

let loremIpsum = "Lorem ipsum dolor sit amet, partem vidisse nostrud ea pri. Nam ut suas veritus tractatos, eu has facilisi tractatos, eu sea erat aperiri posidonium. Veri blandit cu his, ex mei graeci repudiare moderatius. Est ea atqui oportere reformidans, ad mea stet suscipit persecuti, ut ius eros interpretaris.\n\nNe vix suscipit incorrupte, vim soluta admodum denique ut. Sed ne hinc scripserit, id veri oporteat senserit vix. Et vis altera albucius. Id eos delicata concludaturque. Et eam justo cotidieque, eam paulo causae signiferumque at.\n\nEa has elit nonumes, te accusata complectitur has. Eam cu quem facer epicurei. Commodo copiosae evertitur et vix, at duo malis nostro. Pro legere signiferumque et. Eu ubique impedit sea, facer erant te qui.\n\nNostrum repudiare tincidunt ea eum. Sea in alia tempor, munere soleat perpetua pro eu. Vim cu tantas necessitatibus, vis solum dicant repudiare ea. An elit doming pri, ut nibh solet blandit eam, vix rebum impedit at. Sit legere nominati tractatos in. Sanctus repudiare et sed, duis volumus qui ad.\n\nNe usu minim dolore, mei tation audire torquatos ei. Vix vocibus persequeris no. Duis atomorum cum an, sed mutat singulis consectetuer in. Ei affert graece eripuit usu, idque laoreet his ne. His ne nulla mnesarchum theophrastus, no has quas accusam adolescens, cu utamur tibique qui. Vim propriae temporibus ea, pro no posse nostro molestie, probo regione tritani eum in. Liber partiendo vel in, ei veri audire has."

extension String {
	var words: [String] {
		return components(separatedBy: .whitespacesAndNewlines)
	}
	
	var randomWord: String {
		let index = Int(arc4random_uniform(UInt32(words.count)))
		return words[index]
	}
}

extension Date {
	static func randomDateBefore(date: Date) -> Date {
		let limit = date.timeIntervalSinceReferenceDate
		let randomTime = TimeInterval(arc4random_uniform(UInt32(limit)))
		return Date(timeIntervalSinceReferenceDate: randomTime)
	}
}

func addDummyEntries(numberOfEntries: Int) {
	let now = Date()
	for _ in 0..<numberOfEntries {
		let title = loremIpsum.randomWord + " " + loremIpsum.randomWord
		let timestamp = Date.randomDateBefore(date: now)
		let entry = Entry(timestamp: timestamp, title: title, text: loremIpsum)
		EntryController.shared.add(entry: entry)
	}
}
