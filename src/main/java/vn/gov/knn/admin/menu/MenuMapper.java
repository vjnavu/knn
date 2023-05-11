package vn.gov.knn.admin.menu;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MenuMapper {
    Menu getMenuBySeq(int menuSeq);

    int deleteMenuBySeq(int menuSeq);

    int updateMenu(Menu menu);

    List<Menu> getMenuParent();

    List<Menu> getMenuSub(int menuSeq);

    List<Menu> getListMenuParent();

    int saveMenu(Menu menu);

    List<Menu> getListMenuByUrl(String url);

    List<Menu> getListMenuByParent(Menu menu);

    List<Menu> getListMenuThwart(Menu menu);

    List<Menu> getMenuByUrl(String s);
}
