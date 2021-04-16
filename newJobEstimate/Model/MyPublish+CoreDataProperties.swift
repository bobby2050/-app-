//
//  MyPublish+CoreDataProperties.swift
//  newJobEstimate
//
//  Created by 杨宇铎 on 2/16/21.
//
//

import Foundation
import CoreData


extension MyPublish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyPublish> {
        return NSFetchRequest<MyPublish>(entityName: "MyPublish")
    }

    @NSManaged public var city_name: String?
    @NSManaged public var company_name: String?
    @NSManaged public var created_at: String?
    @NSManaged public var department_name: String?
    @NSManaged public var group_name: String?
    @NSManaged public var id: Int64
    @NSManaged public var is_focus: Bool
    @NSManaged public var is_like: Bool
    @NSManaged public var like_count: Int64
    @NSManaged public var nick_name: String?
    @NSManaged public var position_name: String?
    @NSManaged public var province_name: String?
    @NSManaged public var publish_text: String?
    @NSManaged public var reply_count: Int64
    @NSManaged public var status: Int16
    @NSManaged public var updated_at: String?
    @NSManaged public var user_id: Int64
    @NSManaged public var user_name: String?

}

extension MyPublish : Identifiable {

}
