//
//  Publish+CoreDataProperties.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 2/8/21.
//
//

import Foundation
import CoreData


extension Publish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Publish> {
        return NSFetchRequest<Publish>(entityName: "Publish")
    }

    @NSManaged public var id: Int64
    @NSManaged public var user_id: Int64
    @NSManaged public var user_name: String?
    @NSManaged public var nick_name: String?
    @NSManaged public var publish_text: String?
    @NSManaged public var status: Int16
    @NSManaged public var reply_count: Int16
    @NSManaged public var like_count: Int16
    @NSManaged public var company_name: String?
    @NSManaged public var created_at: String?
    @NSManaged public var updated_at: String?
    @NSManaged public var is_like: Bool
    @NSManaged public var is_focus: Bool
    @NSManaged public var department_name: String?
    @NSManaged public var group_name: String?
    @NSManaged public var position_name: String?
    @NSManaged public var province_name: String?
    @NSManaged public var city_name: String?

}

extension Publish : Identifiable {

}
