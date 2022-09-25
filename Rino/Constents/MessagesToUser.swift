//
//  MessagesToUser.swift
//  Rino
//
//  Created by Ayman Omara on 02/09/2021.
//
//MARK:- This class is responsable for messages to the user in tuble data Structure
import Foundation
struct MessagesToUser{
    static let invaliadLogIn = (message:"الرجاء كتابة اسم المستخدم وكلمة المرور بطريقة صحيحه",title:"خطأ")
    static let empty = (message:"الرجاء ادخال اسم المستخدم وكلمة المرور",title:"خطأ")
    static let logInComplete = (message:"تم تسجيل الدخول بنجاح",titel:"نجح")
    static let noConnection = (message:"لا يوجد اتصال بالانترنت",titel:"خطأ")
    static let serverError = (message:"Internal server error please try again later",statusCode:500)
    static let timeOut = (message:"عاود المحاوله مره اخرى",statusCode:400)
    static let passwordnotQualified = "هذا الرقم السري لا يطابق المعايير"
    static let passwordsIsnotEqual = "كلمتا المرور غير متطابقتين"
    static let passwordisQualified = "كلمه المرور مطابقه للمعايير"
    
}
