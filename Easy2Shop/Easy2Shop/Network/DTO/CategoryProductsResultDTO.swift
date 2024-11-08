//
//  CategoryProductsResultDTO.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import Foundation

/// Структура для представления результата с продуктами в категории
struct CategoryProductsResultDTO: Codable {
    
    /// Список продуктов в выбранной категории
    let products: [ProductDTO]
    
    /// Общее количество доступных продуктов в категории
    let total: Int
    
    /// Количество пропущенных элементов для пагинации
    let skip: Int
    
    /// Лимит количества продуктов, возвращаемых в одном запросе
    let limit: Int
}
