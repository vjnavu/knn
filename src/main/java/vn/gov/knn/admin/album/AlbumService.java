package vn.gov.knn.admin.album;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.gov.knn.admin.file.FileService;
import vn.gov.knn.admin.file.FileVO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class AlbumService {
    @Autowired
    private AlbumMapper albumMapper;

    @Autowired
    private FileService fileService;

    public int saveNewAlbum(Album album) {
        return albumMapper.saveNewAlbum(album);
    }

    public List<Album> getListAlbum(Album album) {
        album.setOffset((album.getPage() - 1) * album.getSize());
        return albumMapper.getListAlbum(album);
    }

    public int countAlbum(Album album) {
        return albumMapper.countAlbum(album);
    }

    public int deleteAlbum(int albumSeq) throws IOException {
        return albumMapper.deleteAlbum(albumSeq);
    }

    public Album getAlbumBySeq(int albumSeq) {
        return albumMapper.getAlbumBySeq(albumSeq);
    }

    public int updateSave(Album album) {
        return albumMapper.updateSave(album);
    }

    public List<Album> getAlbumsByExamSeq(int examSeq) {
        return albumMapper.getAlbumsByExamSeq(examSeq);
    }

    public List<Album> getAllAlbum(Album album) {
        album.setOffset((album.getPage() - 1) * album.getSize());
        return albumMapper.getAllAlbum(album);
    }

    public List<Album> getAlbumByLimit(int number) {
        List<Album> albums = albumMapper.getAlbumByLimit(number);
        if(albums.size() > 0){
            for(Album album: albums){
                List<FileVO> fileVOS = new ArrayList<>();
                if (album.getAlbum_img().length() > 0) {
                    int[] img = Arrays.stream(album.getAlbum_img().split(",")).mapToInt(Integer::parseInt).toArray();
                    if (img != null && img.length > 0) {
                        for (int i : img) {
                            FileVO fileVO = fileService.getFileBySeq(i);
                            fileVOS.add(fileVO);
                        }
                    }
                }
                album.setAlbum(fileVOS);
            }
        }
        return albums;
    }
}
