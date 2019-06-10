function u = quiver_maker(smile, num_landmarks, smile_pts, non_smile_pts, variance)
u = zeros(size(smile,1), size(smile,2),2);
for y = 1:size(smile,1)
    for x = 1:size(smile,2)
        for i = 1:num_landmarks
            for j = 1:2
                % Pi is the landmark changing value (Difference between smile and non smile
                Pi(i,j) = (smile_pts(i,j) - non_smile_pts(i,j));
            end 
            r = exp(-((x-non_smile_pts(i,1))^2 + (y-non_smile_pts(i,2))^2)/(2*(variance^2)))*Pi(i,1);
            q = exp(-((x-non_smile_pts(i,1))^2 + (y-non_smile_pts(i,2))^2)/(2*(variance^2)))*Pi(i,2);
            u(y,x,1) = u(y,x,1) + r;
            u(y,x,2) = u(y,x,2) + q;
        end
    end
end
