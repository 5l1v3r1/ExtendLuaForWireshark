--[=======[
-------- -------- -------- --------
  Tencent SSO 2  >>>> KeyChain
-------- -------- -------- --------

�½�ȫ�ֺ���TXSSO2_Add2KeyChain��������KeyChain���������Key

���س�����

KeyChain�е�KeyName�������ظ�
KeyChain�е�Key�������ʱ�����۳�����Σ������̶�Ϊ0x10�����Ȳ��㣬��\0���룬���ȹ�������ض�
]=======]
local keychain = {};

--�ṩ�������ڽ�KEY����KeyChain
function TXSSO2_Add2KeyChain( key_name, key )
  if not key_name then
    return error( "����KeyChain��ָ��KeyName" );
  end
  if type( key_name ) ~= "string" then
    return error( "����KeyChain��KeyName����Ϊstring����" );
  end
  if keychain[ key_name ] then
    if keychain[ key_name ] ~= key then
      return error( "����KeyChainʱKeyName[" .. key_name .. "]�ظ�" );
    else
      return;
    end
  end
  if type( key ) ~= "string" then
    return error( "����KeyChain��Key����Ϊstring����" );
  end
print( "Add", key_name, key);
  keychain[ key_name ] = key;
end

function TXSSO2_MakeKeyName( CsCmdNo, Seq, FrameNum )
  return string.format( "c%04Xs%04Xf%04X", CsCmdNo, Seq, FrameNum );
end

TXSSO2_Add2KeyChain( TXSSO2_MakeKeyName( 1, 1, 1 ), "02111" );

return setmetatable(
  {},
  {
  __index = keychain;
  __pairs = function( ) return next, keychain, nil; end;
  __newindex = function()
    return error( "KeyChain��ֹ�ⲿ�޸ģ���ʹ��[TXSSO2_Add2KeyChain]�������" );
  end
  }
  );