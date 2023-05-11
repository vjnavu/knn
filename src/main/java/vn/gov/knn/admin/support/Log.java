/*
  User: VTA
  Date: 6/21/2021 4:14 PM
*/
package vn.gov.knn.admin.support;

import org.springframework.stereotype.Component;


@Component
public class Log {
    public static void log(Object msg){
        System.out.println(" ========= " + msg);}
}
