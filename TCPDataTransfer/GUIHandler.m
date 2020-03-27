//
//  GUIHandler.m
//  TCPDataTransfer
//
//  Created by Dmitry Kolesnikovich on 3/27/20.
//  Copyright © 2020 Dmitry Kolesnikovich. All rights reserved.
//

#import "GUIHandler.h"


@implementation GUIHandler

- (IBAction)StartServerNow:(id)sender {
    obj_server_thread = [[ServerThread alloc] init];
    [obj_server_thread initializeServer: tx_recieved_data];
    [obj_server_thread start];
}

- (IBAction)StopServerNow:(id)sender {
    [obj_server_thread stopServer];
    [obj_server_thread cancel];
}

- (IBAction)ConnectToSever:(id)sender {
    obj_client_thread = [[ClientThread alloc] init];
    [obj_client_thread initializeClient];
    [obj_client_thread start];
}

- (IBAction)DisconnectFromServer:(id)sender {
    [obj_client_thread disconnectFromServer];
    [obj_client_thread cancel];
}

- (IBAction)SendData:(id)sender {
    [obj_client_thread sendTcpDataPacket:[[tx_send_data stringValue] UTF8String]];
}
@end

