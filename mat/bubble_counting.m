% 내가 보려고 하는 사진의 경로
folder_path = '/Users/leejungbin/Desktop/train_set/postProcessing/';
% compare_path = '/Users/leejungbin/Desktop/train_set/test/';

% 결과를 추가할 txt 파일 경로
file_list = dir(fullfile(folder_path, '*.tif'));

% 객체가 없는 사진의 결과 이미지 미리 이진화
% comp_path1 = fullfile(compare_path, '0001.tif');
% img2_data = imread(comp_path1);
% 
% threshold = 0.5;
% binary2_image = imbinarize(img2_data,threshold);
% labeled_image2 = bwlabel(binary2_image, 8); % 객체를 라벨링
% num_bubbles2 = max(labeled_image2(:));

% 결과를 추가할 txt 파일 경로
output_file_path = fullfile(folder_path, 'existing_bubbles_count.txt');
fid = fopen(output_file_path, 'a');  % 파일 열기 (추가 모드)


for i = 1: length(file_list) % 파일 개수 확인
    file_name = file_list(i).name;
    file_path1 = fullfile(folder_path, file_name);

    img_data = imread(file_path1);
    
%     binary_image = imbinarize(img_data);
    
    % 객체 탐지 (버블을 식별)
    labeled_image = bwlabel(img_data,8); % 객체를 라벨링
    num_bubbles = max(labeled_image(:));
    %total = num_bubbles - num_bubbles2;
    fprintf(fid ,'%s: 버블의 개수 = %d\n', file_name, num_bubbles);
end


fclose(fid);
