//
//  DoctorListingCell.h
//  Ziffi
//
//  Created by Hardik on 13/05/15.
//  Copyright (c) 2015 Docsuggest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface DoctorListingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *doctorDegree;
@property (weak, nonatomic) IBOutlet UILabel *doctorExp;
@property (weak, nonatomic) IBOutlet UILabel *doctorFees;
@property (weak, nonatomic) IBOutlet UILabel *doctorDistance;
@property (weak, nonatomic) IBOutlet UILabel *doctorReviews;
@property (weak, nonatomic) IBOutlet UILabel *doctorSpeciality;
@property (weak, nonatomic) IBOutlet UILabel *doctorHospitals;
@property (weak, nonatomic) IBOutlet UILabel *doctorWorkingAt;
@property (weak, nonatomic) IBOutlet UIImageView *doctorImage;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *doctorsRating;

@end
