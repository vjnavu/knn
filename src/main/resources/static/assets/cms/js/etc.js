const dt = new DataTransfer();
var deteleFileSeqCtn = 0;
/*const fileNameArray= [];*/
$("#submitFile").on('change', function (e) {
    var WHITE_LIST;
    // var getWhileListByClassName = $('.fileExt').text();
    // if(getWhileListByClassName != '' || getWhileListByClassName != null){
    //     WHITE_LIST = getWhileListByClassName;
    // }else {
    //     WHITE_LIST  ='jpeg,jpg,png,gif,bmp,hwp,txt,pdf,doc,docx,csv,xls,xlsx,ppt,pptx,zip,7z,gz,tar,rar';
    // }

    WHITE_LIST = 'jpeg,jpg,png,gif,bmp,hwp,txt,pdf,doc,docx,csv,xls,xlsx,ppt,pptx,zip,7z,gz,tar,rar';

    for (let file of this.files) {
        var fileName = file.name;
        var fileExt = fileName.substring(fileName.lastIndexOf(".") + 1);

        /*Check trung file*/
        /*if(fileNameArray.indexOf(fileName) <= -1){
            if(file.size > (20 * 1024 * 1024) || (WHITE_LIST.indexOf(fileExt) < 0)){
                if(file.size > (20 * 1024 * 1024)){
                    alert("Giới hạn kích thước của tệp là 20Mb.");
                }else{
                    alert("Định dạng của tệp không được hỗ trợ - "+fileName);
                }
            }
            else{
                fileNameArray.push(fileName);
                dt.items.add(file);
            }
        }*/

        /*K check trung file*/

        if (file.size > (50 * 1024 * 1024) || (WHITE_LIST.indexOf(fileExt) < 0)) {
            if (file.size > (50 * 1024 * 1024)) {
                alert("Giới hạn kích thước của tệp là 50Mb.");
            } else {
                alert("Định dạng của tệp không được hỗ trợ - " + fileName);
            }
        } else {
            /*fileNameArray.push(fileName);*/
            dt.items.add(file);
        }

    }

    document.getElementById('submitFile').files = dt.files;
    $('.file-block').remove();
    for (var i = 0; i < this.files.length; i++) {
        let fileBloc = $('<span/>', {class: 'file-block'}),
            fileName = $('<span/>', {class: 'name', text: this.files.item(i).name});
        fileBloc.append('<span class="file-delete"><span>+</span></span>')
            .append(fileName);
        $("#filesList > #files-names").append(fileBloc);
    }
    ;
    $('span.file-delete').click(function () {
        let name = $(this).next('span.name').text();
        $(this).parent().remove();
        for (let i = 0; i < dt.items.length; i++) {
            if (name === dt.items[i].getAsFile().name) {
                dt.items.remove(i);
                /*fileNameArray.splice(fileNameArray.indexOf(name),1);*/
                continue;
            }
        }
        document.getElementById('submitFile').files = dt.files;
    });
});

$('.imp-Files-deltete').click(function () {
    var deleteFileSeq = $(this).attr("data-fileSeq");
    console.log(deleteFileSeq);
    $(this).closest($('.imp-Files-class')).remove();
    if (deleteFileSeq != null && deleteFileSeq != '') {
        $('#deleteFileSeqs').append('<input type="hidden" name="deleteFileSeqList[' + deteleFileSeqCtn + ']" value="' + deleteFileSeq + '"/>');
        deteleFileSeqCtn++;
    }
})