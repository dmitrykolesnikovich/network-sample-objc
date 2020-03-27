//
//  ServerThread.m
//  TCPDataTransfer
//
//  Created by Dmitry Kolesnikovich on 3/27/20.
//  Copyright © 2020 Dmitry Kolesnikovich. All rights reserved.
//

#import "ServerThread.h"
#import "ClientThread.h"

@implementation ServerThread

-(void) initializeServer:(NSTextField *) target_text_field {
    tx_recv =target_text_field;
    CFSocketContext sctx = { 0, (__bridge void *)(self), NULL, NULL, NULL };
    obj_server = CFSocketCreate(kCFAllocatorDefault, AF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketAcceptCallBack, TCPServerCallbackHandler, &sctx);
    int so_reuse_flag = 1;
    setsockopt(CFSocketGetNative(obj_server), SOL_SOCKET, SO_REUSEADDR, &so_reuse_flag, sizeof(so_reuse_flag));
    setsockopt(CFSocketGetNative(obj_server), SOL_SOCKET, SO_REUSEPORT, &so_reuse_flag, sizeof(so_reuse_flag));
    struct sockaddr_in sock_addr;
    memset(&sock_addr, 0, sizeof(sock_addr));
    sock_addr.sin_len = sizeof(sock_addr);
    sock_addr.sin_family = AF_INET;
    sock_addr.sin_port = htons(6658);
    sock_addr.sin_addr.s_addr = INADDR_ANY;
      
    CFDataRef dref = CFDataCreate(kCFAllocatorDefault, (UInt8*)&sock_addr, sizeof(sock_addr));
    CFSocketSetAddress(obj_server, dref);
    CFRelease(dref);
}

-(void) main {
    CFRunLoopSourceRef loopref = CFSocketCreateRunLoopSource(kCFAllocatorDefault, obj_server, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), loopref, kCFRunLoopDefaultMode);
    CFRelease(loopref);
    CFRunLoopRun();    
}
  
-(void)stopServer {
    CFSocketInvalidate(obj_server);
    CFRelease(obj_server);
    CFRunLoopStop(CFRunLoopGetCurrent());
}

void TCPServerCallbackHandler(CFSocketRef s, CFSocketCallBackType type, CFDataRef address, const void* data, void *info) {
    switch (type) {
        case kCFSocketAcceptCallBack: {
            ServerThread * obj_server_ptr = (__bridge ServerThread *) info;
            ClientThread *obj_accepted_socket = [[ClientThread alloc]init];
            [obj_accepted_socket initializeNative:*(CFSocketNativeHandle*) data showRecvData:obj_server_ptr->tx_recv];
            [obj_accepted_socket start];
            break;
        }            
        default:
            break;
    }
}
@end
