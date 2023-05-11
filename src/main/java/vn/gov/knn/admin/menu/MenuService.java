package vn.gov.knn.admin.menu;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class MenuService {

    @Autowired
    private MenuMapper menuMapper;

    public List<Menu> getListMenu() {
        List<Menu> menuResult = new ArrayList<>();
        List<Menu> menuParent = menuMapper.getMenuParent();
        for (int i = 0; i < menuParent.size(); i++) {
            menuResult.add(menuParent.get(i));
            List<Menu> subMenu = menuMapper.getMenuSub(menuParent.get(i).getMn_seq());
            menuResult.addAll(subMenu);
        }
        return menuResult;
    }

    public Menu getMenuBySeq(int menuSeq) {
        return menuMapper.getMenuBySeq(menuSeq);
    }

    public int deleteMenuBySeq(int menuSeq) {
        return menuMapper.deleteMenuBySeq(menuSeq);
    }

    public List<Menu> getListMenuParent() {
        return menuMapper.getListMenuParent();
    }

    public int updateMenu(Menu menu) {
        menu.setMn_mod_dt(new Date());
        return menuMapper.updateMenu(menu);
    }

    public int saveMenu(Menu menu) {
        menu.setMn_reg_dt(new Date());
        return menuMapper.saveMenu(menu);
    }

    public boolean ckeckUseContent(int conSeq) {
        String url = "/news/content/" + conSeq;
        List<Menu> menus = menuMapper.getListMenuByUrl(url);
        if (menus.size() > 0) return true;
        else return false;
    }

    public boolean ckeckUseBoard(int boardSeq) {
        String url = "/news/board/" + boardSeq;
        List<Menu> menus = menuMapper.getListMenuByUrl(url);
        if (menus.size() > 0) return true;
        else return false;
    }

    public List<Menu> getListMenuByParent(Menu menu) {
        return menuMapper.getListMenuByParent(menu);
    }

    public List<Menu> getListMenuThwart(Menu menu) {
        return menuMapper.getListMenuThwart(menu);
    }

    public List<Menu> getMenuByUrl(String s) {
        return menuMapper.getMenuByUrl(s);
    }
}
