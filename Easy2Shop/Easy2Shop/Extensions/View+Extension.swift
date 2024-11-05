//
//  View+Extension.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 04.11.24.
//

import UIKit

/// Расширение для UIView, добавляющее удобные методы для работы с подвиджетами (subviews)
/// и установки закругленных углов у элементов.
public extension UIView {
    
    /// Метод для добавления нескольких subviews в UIView.
    /// - Примечание: Данный метод также позволяет отключить `translatesAutoresizingMaskIntoConstraints` для
    /// добавляемых subviews, что упрощает настройку Auto Layout.
    ///
    /// - Parameter views: Массив `UIView`, которые нужно добавить как subviews.
    /// - Parameter needToPrepare: Булевое значение, определяющее, нужно ли отключать `translatesAutoresizingMaskIntoConstraints`
    /// у добавляемых subviews. По умолчанию это значение `true`.
    ///
    /// - Пример использования:
    /// ```
    /// let containerView = UIView()
    /// let label = UILabel()
    /// let button = UIButton()
    /// containerView.addSubviews([label, button])
    /// ```
    func addSubviews(
        _ views: [UIView],
        prepareForAutolayout needToPrepare: Bool = true
    ) {
        views.forEach {
            addSubview(needToPrepare ? prepareForAutoLayout($0) : $0)
        }
    }
    
}
