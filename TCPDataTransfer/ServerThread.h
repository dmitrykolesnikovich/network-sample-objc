//
//  ServerThread.h
//  TCPDataTransfer
//
//  Created by Dmitry Kolesnikovich on 3/27/20.
//  Copyright © 2020 Dmitry Kolesnikovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#include <sys/socket.h>
#include <netinet/in.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerThread : NSThread
{
    CFSocketRef obj_server;
    @public
    NSTextField *tx_recv;
}

-(void)initializeServer:(NSTextField *) target_text_field;
-(void)main;
-(void)stopServer;
@end

NS_ASSUME_NONNULL_END
