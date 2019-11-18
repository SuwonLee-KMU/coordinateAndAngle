 % Generated on: 190826
% Author: Suwon Lee from Seoul National University

classdef quaternion
  properties
    q0
    q1
    q2
    q3
  end

  methods
    function obj = quaternion(v0,v1,v2,v3)
      obj.q0 = v0;
      obj.q1 = v1;
      obj.q2 = v2;
      obj.q3 = v3;
    end
    function q = plus(obj,quatObj)
      if isa(quatObj,'quaternion')
        q = quaternion(obj.q0+quatObj.q0,obj.q1+quatObj.q1,obj.q2+quatObj.q2,obj.q3+quatObj.q3);
      else
        error('Invalid quatObj');
      end
    end
    function q = minus(obj,quatObj)
      if isa(quatObj,'quaternion')
        q = quaternion(obj.q0-quatObj.q0,obj.q1-quatObj.q1,obj.q2-quatObj.q2,obj.q3-quatObj.q3);
      else
        error('Invalid quatObj');
      end
    end
    function q = mtimes(obj,quatObj)
      if isnumeric(quatObj)
        n = quatObj;
        q = quaternion(obj.q0*n,obj.q1*n,obj.q2*n,obj.q3*n);
      elseif and(isnumeric(obj),~isnumeric(quatObj))
        n = obj;
        q = quaternion(quatObj.q0*n,quatObj.q1*n,quatObj.q2*n,quatObj.q3*n);
      elseif and(~isnumeric(quatObj),~isnumeric(obj))
        Q = [obj.q0, -obj.q1, -obj.q2, -obj.q3;
        obj.q1, obj.q0, -obj.q3, obj.q2;
        obj.q2, obj.q3, obj.q0, -obj.q1;
        obj.q3, -obj.q2, obj.q1, obj.q0];
        q_ = Q*[quatObj.q0; quatObj.q1; quatObj.q2; quatObj.q3];
        q  = quaternion(q_(1),q_(2),q_(3),q_(4));
      else
        error('invalid multiplication')
      end
    end
    function q = mrdivide(obj,obj2)
      if and(isa(obj,'quaternion'),isa(obj2,'double'))
        q = obj*(1/obj2);
      else
        error('inverse quaternions is not supported yet..');
      end
    end
    function q = conj(obj)
      q = quaternion(obj.q0,-obj.q1,-obj.q2,-obj.q3);
    end
    function mag = norm(obj)
      mag = norm([obj.q0,obj.q1,obj.q2,obj.q3]);
    end
    function q = unit(obj)
      q = obj/norm(obj);
    end
    function q13 = vector(obj)
      q13 = [obj.q1;obj.q2;obj.q3];
    end
    function q0 = scalar(obj)
      q0 = obj.q0;
    end
    function q13x = skew(obj)
      q13x = [0, -obj.q3, obj.q2;...
              obj.q3, 0, -obj.q1;...
             -obj.q2, obj.q1, 0];
    end
    function Q = multMtx4(obj)
      q0 = obj.q0;
      q1 = obj.q1;
      q2 = obj.q2;
      q3 = obj.q3;
      Q = [q0,-q1,-q2,-q3; q1,q0,-q3,q2;q2,q3,q0,-q1;q3,-q2,q1,q0];
    end
    function Qbar = multMtx4bar(obj)
      q0 = obj.q0;
      q1 = obj.q1;
      q2 = obj.q2;
      q3 = obj.q3;
      Qbar = [q0,-q1,-q2,-q3; q1,q0,q3,-q2; q2,-q3,q0,q1;q3,q2,-q1,q0];
    end
    function arr = quat2array(obj)
      arr(1,1) = obj.q0;
      arr(2,1) = obj.q1;
      arr(3,1) = obj.q2;
      arr(4,1) = obj.q3;
    end
  end
end