//
//  ClientThread.h
//  TCPDataTransfer
//
//  Created by Dmitry Kolesnikovich on 3/27/20.
//  Copyright © 2020 Dmitry Kolesnikovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClientThread : NSThread
{
    CFSocketRef obj_client;
    @public
    NSTextField* tx_recv;
}

-(void)initializeClient;
-(void)initializeNative:(CFSocketNativeHandle) native_socket showRecvData:(NSTextField *) target_text_field;
-(void)main;
-(void)disconnectFromServer;
-(void)sendTcpDataPacket:(const char*) data;
-(char*)ReadData;
@end

NS_ASSUME_NONNULL_END
