//
//  GUIHandler.h
//  TCPDataTransfer
//
//  Created by Dmitry Kolesnikovich on 3/27/20.
//  Copyright © 2020 Dmitry Kolesnikovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "ServerThread.h"
#import "ClientThread.h"

NS_ASSUME_NONNULL_BEGIN

@interface GUIHandler : NSObject {
    ServerThread *obj_server_thread;
    ClientThread *obj_client_thread;
    @public
    __weak IBOutlet NSTextField *tx_recieved_data;
    __weak IBOutlet NSTextField *tx_send_data;
}
- (IBAction)StartServerNow:(id)sender;
- (IBAction)StopServerNow:(id)sender;
- (IBAction)ConnectToSever:(id)sender;
- (IBAction)DisconnectFromServer:(id)sender;
- (IBAction)SendData:(id)sender;

@end

NS_ASSUME_NONNULL_END
