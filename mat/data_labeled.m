% 내가 보려고 하는 사진의 경로
folder_path = '/Users/leejungbin/Documents/MATLAB/results/';

% 비교 폴더
compare_path = '/Users/leejungbin/Documents/MATLAB/postProcessing/';

output_path = '/Users/leejungbin/Documents/MATLAB/renew/';

% 디렉토리에서 '*.tif' 확장자를 가진 파일들의 목록을 가져옴
file_list = dir(fullfile(folder_path, 'postProcessing1000.tif'));
compare_file_list = dir(fullfile(compare_path, 'pP1000.tif'));

for i = 1:length(file_list) % 파일 개수 확인
    file_name = file_list(i).name;
    compare_name = compare_file_list(i).name;

    file_path1 = fullfile(folder_path, file_name);
    compare_file_path1 = fullfile(compare_path, compare_name);

    img_data = imread(file_path1);
    compare_img_data = imread(compare_file_path1);

    % 이미지 white & black 반전
    inverted_image_data = ~img_data;
    inverted_compare_image_data = ~compare_img_data;

    % 객체 탐지 (버블을 식별)
    labeled_image = bwlabel(inverted_image_data, 8); % 객체를 라벨링
    relabeled_image = bwlabel(inverted_compare_image_data, 8); % 객체를 라벨링

    % 두 이미지의 라벨링이 동일한지 확인
    common_labels = labeled_image & relabeled_image;


    common_image = bwlabel(common_labels, 8);

    % 라벨링된 객체 개수 세기
    num_common_objects = max(common_image(:));

    % 결과 출력
    fprintf('공통으로 라벨링된 객체 개수(%d) : %d\n', i , num_common_objects);

    % 라벨링된 객체만 표시하는 마스크 생성 (흰색 배경)
    labeled_mask = ~labeled_image;
    relabeled_mask = ~relabeled_image;

    result = relabeled_image - relabeled_mask; 

    % 라벨링된 객체만 추출하여 컬러 이미지 출력
    colored_labels = label2rgb(labeled_mask, 'jet', 'w', 'shuffle'); % 'jet' colormap 사용, 배경은 흰색('w')
    figure;
    imshow(colored_labels);

    colored_labelsi = label2rgb(result, 'jet', 'w', 'shuffle'); % 'jet' colormap 사용, 배경은 흰색('w')
    figure;
    imshow(colored_labelsi);

end


