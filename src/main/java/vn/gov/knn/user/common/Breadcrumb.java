package vn.gov.knn.user.common;

import vn.gov.knn.admin.menu.Menu;


public class Breadcrumb {
    private Menu menuC1;
    private Menu menuC2;
    private Menu menuC3;

    public Breadcrumb() {
        menuC1 = new Menu();
        menuC3 = new Menu();
        menuC2 = new Menu();
    }

    public Menu getMenuC1() {
        return menuC1;
    }

    public void setMenuC1(Menu menuC1) {
        this.menuC1 = menuC1;
    }

    public Menu getMenuC2() {
        return menuC2;
    }

    public void setMenuC2(Menu menuC2) {
        this.menuC2 = menuC2;
    }

    public Menu getMenuC3() {
        return menuC3;
    }

    public void setMenuC3(Menu menuC3) {
        this.menuC3 = menuC3;
    }
}
