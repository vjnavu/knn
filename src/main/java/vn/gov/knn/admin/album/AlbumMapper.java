package vn.gov.knn.admin.album;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AlbumMapper {
    int saveNewAlbum(Album album);

    List<Album> getListAlbum(Album album);

    int countAlbum(Album album);

    int deleteAlbum(int albumSeq);

    Album getAlbumBySeq(int albumSeq);

    int updateSave(Album album);

    List<Album> getAlbumsByExamSeq(int examSeq);

    List<Album> getAllAlbum(Album album);

    List<Album> getAlbumByLimit(int number);
}
