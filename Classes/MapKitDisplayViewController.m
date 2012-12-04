//
//  MapKitDisplayViewController.m
//  MapKitDisplay
//
//  Created by Chakra on 12/07/10.
//  Copyright Chakra Interactive Pvt Ltd 2010. All rights reserved.
//

#import "MapKitDisplayViewController.h"
#import "DisplayMap.h"

@implementation MapKitDisplayViewController

@synthesize mapView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = 22.569722 ;
	region.center.longitude = 88.369722;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES]; 
	
	[mapView setDelegate:self];
	
	DisplayMap *ann = [[DisplayMap alloc] init]; 
	ann.title = @" Kolkata";
	ann.subtitle = @"Mahatma Gandhi Road"; 
	ann.coordinate = region.center; 
	[mapView addAnnotation:ann];
    
    DisplayMap *puneLocation = [[DisplayMap alloc] init];
    puneLocation.title = @"Mumbai";
    puneLocation.subtitle = @"Maharashtra";
    CLLocationCoordinate2D coord = {19.12, 73.02};
    puneLocation.coordinate = coord;
    [mapView addAnnotation:puneLocation];
    
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:22.569722 longitude:88.369722];
    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:19.12 longitude:73.02];

    // calculate distance between them
    CLLocationDistance distance = [loc1 distanceFromLocation:loc2]; // CLLocationDistance is in Meter
    NSLog(@"Distance between two locations in Meter = %f \n Mile = %f \n KiloMeter = %f", distance, distance * 0.000621371192, distance /1000); 
    // 1 Meter = 0.000621371192 Miles 
    // 1 Mile = 1609.344 Meters
}



-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation: (id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];

		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
        UIImage *flagImage = [UIImage imageNamed:@"India.png"];
        // You may need to resize the image here.
        
        
        CGSize size = CGRectMake(0, 0, 30, 30).size;
        UIGraphicsBeginImageContext(size);
        [flagImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        pinView.image = destImage;
		}
	else {
		[mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mapView release];
    [super dealloc];
}

@end
