//
//  ProductDTO.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 06.11.24.
//

import Foundation

/// Структура для представления продукта
struct ProductDTO: Codable {
    
    /// Уникальный идентификатор продукта
    let id: Int
    
    /// Название продукта
    let title: String
    
    /// Описание продукта
    let description: String
    
    /// Категория, к которой относится продукт
    let category: String
    
    /// Цена продукта
    let price: Double
    
    /// Рейтинг продукта
    let rating: Double
    
    /// Список URL изображений продукта
    let images: [String]
}

