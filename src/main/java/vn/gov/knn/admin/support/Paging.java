package vn.gov.knn.admin.support;

public class Paging {
    protected int size; // Page size
    protected int startRow;
    protected int endRow;
    protected int page; // current Page

    protected String order; // Order by
    protected String sort; // ASC - DESC

    protected String searchItem;
    protected String keyWord;

    protected int offset;

    public int getSize() {
        return size == 0 ? 10 : size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getPage() {
        return page == 0 ? 1 : page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getStartRow() {
        if (this.getPage() == 1) {
            return 1;
        } else {
            return (this.getPage() - 1) * this.getSize() + 1;
        }
    }

    public void setStartRow(int startRow) {
        this.startRow = startRow;
    }

    public int getEndRow() {
        return this.getStartRow() + this.getSize() - 1;
    }

    public void setEndRow(int endRow) {
        this.endRow = endRow;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getKeyWord() {
        return keyWord;
    }

    public void setKeyWord(String keyWord) {
        this.keyWord = keyWord;
    }

    public String getSearchItem() {
        return searchItem;
    }

    public void setSearchItem(String searchItem) {
        this.searchItem = searchItem;
    }

    public int getOffset() {
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }
}
